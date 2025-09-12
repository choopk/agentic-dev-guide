#!/bin/bash
# Save conversation history locally when Claude Code session ends

# Read hook input from stdin
input=$(cat)
transcript_path=$(echo "$input" | jq -r '.transcript_path')
session_id=$(echo "$input" | jq -r '.session_id')
reason=$(echo "$input" | jq -r '.reason // "unknown"')

# Ensure logs directory exists
project_dir="${CLAUDE_PROJECT_DIR:-$(pwd)}"
mkdir -p "$project_dir/.claude/logs"

# Create timestamp for filename
timestamp=$(date +%Y%m%d-%H%M%S)

# Copy conversation file with descriptive name
if [ -f "$transcript_path" ]; then
    cp "$transcript_path" "$project_dir/.claude/logs/conversation-$timestamp-$session_id.jsonl"
    
    # Log session info
    echo "[$timestamp] Session $session_id ended (reason: $reason) - saved to conversation-$timestamp-$session_id.jsonl" >> "$project_dir/.claude/logs/session-history.txt"
else
    echo "[$timestamp] Session $session_id ended but transcript not found at $transcript_path" >> "$project_dir/.claude/logs/session-history.txt"
fi