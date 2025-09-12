#!/bin/bash
# Context Bundle Manager
# Utilities for managing context bundle lifecycle and operations

project_dir="${CLAUDE_PROJECT_DIR:-$(pwd)}"
bundle_base_dir="$project_dir/.claude/context-bundles"

# Function to list available bundles
list_bundles() {
    echo "📦 Available Context Bundles:"
    echo ""
    
    if [ ! -d "$bundle_base_dir" ]; then
        echo "No context bundles found. Start using Claude Code to generate some!"
        return
    fi
    
    find "$bundle_base_dir" -name "*.json" -type f | sort -r | while read bundle; do
        rel_path=${bundle#$bundle_base_dir/}
        size=$(stat -c %s "$bundle" 2>/dev/null || echo 0)
        human_size=$(numfmt --to=iec --suffix=B $size 2>/dev/null || echo "${size}B")
        mtime=$(stat -c %Y "$bundle" 2>/dev/null || echo 0)
        age_hours=$(( ($(date +%s) - mtime) / 3600 ))
        
        # Get entry count and summary
        entry_count=$(wc -l < "$bundle" 2>/dev/null || echo 0)
        first_entry=$(head -1 "$bundle" 2>/dev/null | jq -r '.operation + " - " + (.timestamp // "unknown")' 2>/dev/null || echo "Invalid bundle")
        
        echo "🗂️  $rel_path"
        echo "   📊 Size: $human_size | Entries: $entry_count | Age: ${age_hours}h"
        echo "   🔄 Start: $first_entry"
        echo ""
    done
}

# Function to get recent bundles
get_recent_bundles() {
    local count=${1:-5}
    
    echo "📦 Recent Context Bundles (last $count):"
    echo ""
    
    if [ ! -d "$bundle_base_dir" ]; then
        echo "No context bundles found."
        return
    fi
    
    find "$bundle_base_dir" -name "*.json" -type f -exec stat -c "%Y %n" {} \; | 
    sort -nr | 
    head -$count | 
    while read mtime bundle; do
        rel_path=${bundle#$bundle_base_dir/}
        age_hours=$(( ($(date +%s) - mtime) / 3600 ))
        entry_count=$(wc -l < "$bundle" 2>/dev/null || echo 0)
        
        echo "🗂️  $rel_path (${age_hours}h ago, $entry_count entries)"
    done
}

# Function to load and process a bundle
load_bundle() {
    local bundle_path="$1"
    
    # Handle relative paths
    if [[ "$bundle_path" != /* ]]; then
        bundle_path="$project_dir/$bundle_path"
    fi
    
    if [ ! -f "$bundle_path" ]; then
        echo "❌ Bundle not found: $bundle_path" >&2
        return 1
    fi
    
    echo "📖 Loading Context Bundle: $(basename "$bundle_path")"
    echo ""
    
    # Parse and summarize bundle contents
    local session_id=$(head -1 "$bundle_path" | jq -r '.session_id // "unknown"')
    local start_time=$(head -1 "$bundle_path" | jq -r '.timestamp // "unknown"')
    local end_time=$(tail -1 "$bundle_path" | jq -r '.timestamp // "unknown"')
    local total_entries=$(wc -l < "$bundle_path")
    
    echo "🔄 **Session**: $session_id"
    echo "⏰ **Duration**: $start_time → $end_time"
    echo "📊 **Total Operations**: $total_entries"
    echo ""
    
    echo "## 🗂️ File Operations Summary"
    echo ""
    
    # Summarize file operations
    grep '"tool_name": ".*"' "$bundle_path" | \
    jq -r 'select(.tool_name == "Read" or .tool_name == "Write" or .tool_name == "Edit" or .tool_name == "MultiEdit") | "\(.tool_name): \(.tool_input.file_path // "unknown")"' | \
    sort | uniq -c | sort -nr | head -10 | \
    while read count operation; do
        echo "- **$operation** (${count}x)"
    done
    
    echo ""
    echo "## 🔧 Tool Usage Summary" 
    echo ""
    
    # Summarize tool usage
    grep '"tool_name":' "$bundle_path" | \
    jq -r '.tool_name' | \
    sort | uniq -c | sort -nr | \
    while read count tool; do
        echo "- **$tool**: ${count} operations"
    done
    
    echo ""
    echo "## 💡 Key Insights"
    echo ""
    
    # Extract key insights
    local bash_commands=$(grep '"tool_name": "Bash"' "$bundle_path" | wc -l)
    local task_delegations=$(grep '"tool_name": "Task"' "$bundle_path" | wc -l)
    local file_reads=$(grep '"tool_name": "Read"' "$bundle_path" | wc -l)
    local file_writes=$(grep '"tool_name": "Write"' "$bundle_path" | grep -v '"tool_name": "TodoWrite"' | wc -l)
    
    echo "- Executed $bash_commands shell commands"
    echo "- Delegated $task_delegations tasks to sub-agents"
    echo "- Read $file_reads files for analysis"
    echo "- Created/modified $file_writes files"
    
    # Show recent commands for context
    echo ""
    echo "## 🖥️ Recent Commands (last 5)"
    echo ""
    
    grep '"tool_name": "Bash"' "$bundle_path" | tail -5 | \
    jq -r '.tool_input.command // "unknown"' | \
    while read cmd; do
        echo "\`$cmd\`"
    done
    
    echo ""
    echo "## 📝 Context Continuation Notes"
    echo ""
    echo "- Previous agent was working on tasks involving the above file operations"
    echo "- Check recent file modifications to understand current state"
    echo "- Review any TODO items that may still be pending"
    echo "- Consider the command history to understand the workflow context"
    echo ""
    echo "✅ **Context bundle loaded successfully!**"
}

# Function to clean old bundles
cleanup_bundles() {
    local days=${1:-7}
    echo "🧹 Cleaning context bundles older than $days days..."
    
    if [ ! -d "$bundle_base_dir" ]; then
        echo "No bundle directory found."
        return
    fi
    
    local cleaned=0
    find "$bundle_base_dir" -type f -name "*.json" -mtime +$days | while read bundle; do
        echo "Removing: $(basename "$bundle")"
        rm "$bundle"
        cleaned=$((cleaned + 1))
    done
    
    # Remove empty directories
    find "$bundle_base_dir" -type d -empty -delete 2>/dev/null || true
    
    echo "✅ Cleanup complete!"
}

# Main command dispatcher
case "${1:-list}" in
    "list")
        list_bundles
        ;;
    "recent")
        get_recent_bundles "${2:-5}"
        ;;
    "load")
        if [ -z "$2" ]; then
            echo "Usage: $0 load <bundle_path>" >&2
            exit 1
        fi
        load_bundle "$2"
        ;;
    "cleanup")
        cleanup_bundles "${2:-7}"
        ;;
    "help")
        echo "Context Bundle Manager"
        echo ""
        echo "Usage:"
        echo "  $0 list                 - List all available bundles"
        echo "  $0 recent [n]          - Show n recent bundles (default: 5)"
        echo "  $0 load <bundle_path>  - Load and summarize a bundle"
        echo "  $0 cleanup [days]      - Remove bundles older than days (default: 7)"
        echo "  $0 help                - Show this help"
        ;;
    *)
        # If first argument looks like a path, assume it's a load operation
        if [[ "$1" == *.json ]] || [[ "$1" == .claude/context-bundles/* ]]; then
            load_bundle "$1"
        else
            echo "Unknown command: $1" >&2
            echo "Use '$0 help' for usage information." >&2
            exit 1
        fi
        ;;
esac