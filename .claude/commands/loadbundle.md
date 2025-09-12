# Load Context Bundle Command

## Usage
```
/loadbundle [bundle_path]
/loadbundle list
/loadbundle recent [n]
```

## Description
Loads a context bundle to restore previous agent state and continue work from where a previous session left off. Context bundles contain selective execution logs that provide 60-70% understanding of previous agent activities.

## Examples

### Load specific bundle
```
/loadbundle .claude/context-bundles/2025-09-12/14/abc123-session.json
```

### List available bundles  
```
/loadbundle list
```

### Load most recent bundle
```
/loadbundle recent
```

### Load one of the 5 most recent bundles
```
/loadbundle recent 5
```

## Implementation

When you use this command, I will:

1. **Locate the bundle**: Find the specified context bundle file
2. **Load and parse**: Read the JSON log entries from the bundle
3. **Summarize context**: Create a concise summary of:
   - Previous session activities and decisions
   - Files that were read, modified, or created
   - Key tool operations and their outcomes
   - Important patterns or insights from the work
4. **Deduplicate**: Avoid re-reading files that were already processed
5. **Provide continuity**: Give you a clear understanding of where the previous agent left off

## Bundle Structure

Context bundles are stored in:
```
.claude/context-bundles/YYYY-MM-DD/HH/session-id.json
```

Each bundle contains selective tool operation logs with:
- Tool names and key inputs/outputs  
- File operations and changes
- Task delegations and results
- Key decision points and reasoning

## Use Cases

- **Context window overflow**: When your current session context is full
- **Session restoration**: Continue work after a break or system restart  
- **Agent handoffs**: Transfer context between different agents
- **Progress tracking**: Review what previous agents accomplished
- **Debugging**: Understand the trail of work and decisions made

## Notes

- Bundles are automatically created by the context bundle builder hook
- Only essential operations are captured to prevent bundle overflow
- Bundles are rotated automatically (7-day retention by default)
- Use `/listbundles` to see available bundles with metadata