#!/bin/bash
# Todo Persistence Hook
# Saves todo list state for continuity between sessions

input=$(cat)
tool_name=$(echo "$input" | jq -r '.tool_name // "unknown"')

# Only trigger on TodoWrite tool usage
if [ "$tool_name" = "TodoWrite" ]; then
    todos=$(echo "$input" | jq -r '.tool_input.todos // []')
    
    # Save current todos to file
    project_dir="${CLAUDE_PROJECT_DIR:-$(pwd)}"
    echo "$todos" > "$project_dir/.claude/current-todos.json"
    
    # Create a human-readable summary
    timestamp=$(date +%Y%m%d-%H%M%S)
    todo_summary="$project_dir/.claude/todo-summaries/summary-$timestamp.md"
    
    mkdir -p "$project_dir/.claude/todo-summaries"
    
    cat > "$todo_summary" << EOF
# Todo Summary - $timestamp

## Current Status
$(echo "$todos" | jq -r '.[] | "- [\(.status | if . == "completed" then "✅" elif . == "in_progress" then "🔄" else "⏳" end)] \(.content)"')

## Progress Metrics
$(echo "$todos" | jq -r '
  group_by(.status) | 
  map({status: .[0].status, count: length}) | 
  .[] | 
  "- \(.status | ascii_upcase): \(.count) tasks"
')

## Completion Rate
$(echo "$todos" | jq -r '
  length as $total |
  map(select(.status == "completed")) | length as $completed |
  if $total > 0 then 
    ($completed * 100 / $total | floor | tostring) + "% (" + ($completed | tostring) + "/" + ($total | tostring) + ")"
  else 
    "0% (0/0)"
  end
') tasks completed
EOF

    # Log todo activity
    completed_count=$(echo "$todos" | jq '[.[] | select(.status == "completed")] | length')
    total_count=$(echo "$todos" | jq 'length')
    echo "[$timestamp] Todo update: $completed_count/$total_count completed" >> "$project_dir/.claude/todo-activity.log"
    
    # Show progress update
    if [ "$completed_count" -gt 0 ] && [ "$total_count" -gt 0 ]; then
        percentage=$((completed_count * 100 / total_count))
        echo "📋 Progress: ${percentage}% ($completed_count/$total_count tasks completed)" >&2
    fi
fi