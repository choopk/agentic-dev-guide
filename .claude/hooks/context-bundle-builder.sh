#!/bin/bash
# Context Bundle Builder Hook
# Captures selective tool operations into append-only context bundles for agent continuity

input=$(cat)
session_id=$(echo "$input" | jq -r '.session_id // "unknown"')
tool_name=$(echo "$input" | jq -r '.tool_name // "unknown"')
tool_input=$(echo "$input" | jq -r '.tool_input // {}')
tool_response=$(echo "$input" | jq -r '.tool_response // {}')
timestamp=$(date +%Y-%m-%d_%H:%M:%S)
hook_event_name=$(echo "$input" | jq -r '.hook_event_name // "PostToolUse"')

# Only capture for PostToolUse events
if [ "$hook_event_name" != "PostToolUse" ]; then
    exit 0
fi

project_dir="${CLAUDE_PROJECT_DIR:-$(pwd)}"

# Create bundle directory structure: .claude/context-bundles/YYYY-MM-DD/HH/
bundle_date=$(date +%Y-%m-%d)
bundle_hour=$(date +%H)
bundle_dir="$project_dir/.claude/context-bundles/$bundle_date/$bundle_hour"
mkdir -p "$bundle_dir"

# Bundle file path based on session_id
bundle_file="$bundle_dir/$session_id.json"

# Define tools we want to capture (selective filtering)
capture_tools="Read|Write|Edit|MultiEdit|Task|Bash|Grep|Glob|WebFetch|NotebookEdit"

# Skip if tool is not in our capture list
if ! echo "$tool_name" | grep -E "^($capture_tools)$" > /dev/null; then
    exit 0
fi

# Create selective tool input (remove verbose content)
selective_tool_input=$(echo "$tool_input" | jq '
  if .content then
    .content = (.content | if length > 200 then .[0:200] + "..." else . end)
  else . end |
  if .command then
    .command = (.command | if length > 100 then .[0:100] + "..." else . end)
  else . end |
  if .pattern then . else . end |
  if .file_path then . else . end |
  if .prompt then
    .prompt = (.prompt | if length > 150 then .[0:150] + "..." else . end)
  else . end
')

# Create selective tool response (essential info only)
selective_tool_response=$(echo "$tool_response" | jq '
  if .success != null then 
    {success: .success, filePath: .filePath, error: .error}
  else
    if type == "string" and length > 300 then 
      .[0:300] + "..."
    else . end
  end
')

# Create bundle entry
bundle_entry=$(jq -n \
  --arg timestamp "$timestamp" \
  --arg session_id "$session_id" \
  --arg tool_name "$tool_name" \
  --argjson tool_input "$selective_tool_input" \
  --argjson tool_response "$selective_tool_response" \
  '{
    timestamp: $timestamp,
    session_id: $session_id,
    operation: "tool_use",
    tool_name: $tool_name,
    tool_input: $tool_input,
    tool_response: $tool_response
  }'
)

# Append to bundle file (create if doesn't exist)
if [ ! -f "$bundle_file" ]; then
  # Create new bundle with header
  header_entry=$(jq -n \
    --arg timestamp "$timestamp" \
    --arg session_id "$session_id" \
    --arg prompt "Context bundle started" \
    '{
      timestamp: $timestamp,
      session_id: $session_id,
      operation: "session_start",
      prompt: $prompt
    }'
  )
  echo "$header_entry" > "$bundle_file"
fi

# Append the new entry
echo "$bundle_entry" >> "$bundle_file"

# Log bundle activity
echo "[$timestamp] Captured $tool_name operation in bundle $bundle_date/$bundle_hour/$session_id.json" >> "$project_dir/.claude/context-bundle-activity.log"

# Rotate old bundles (keep last 7 days)
find "$project_dir/.claude/context-bundles" -type d -name "????-??-??" -mtime +7 -exec rm -rf {} \; 2>/dev/null || true