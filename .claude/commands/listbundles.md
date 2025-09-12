# List Context Bundles Command

## Usage
```
/listbundles
/listbundles recent [n]
```

## Description
Lists available context bundles with metadata including size, age, and entry count. Helps you find the right bundle to load for session continuation.

## Examples

### List all available bundles
```
/listbundles
```

### Show recent bundles only
```
/listbundles recent
/listbundles recent 10
```

## Implementation

When you use this command, I will run the context bundle manager to show:

- **Bundle location**: Path relative to project root
- **Bundle size**: Human-readable file size  
- **Entry count**: Number of operations captured
- **Age**: Hours since bundle was last modified
- **Session info**: Initial operation and timestamp

## Output Format

```
📦 Available Context Bundles:

🗂️  2025-09-12/14/abc123-session.json
   📊 Size: 2.3KB | Entries: 24 | Age: 2h
   🔄 Start: session_start - 2025-09-12_14:32:15

🗂️  2025-09-12/13/xyz789-session.json  
   📊 Size: 1.8KB | Entries: 18 | Age: 3h
   🔄 Start: session_start - 2025-09-12_13:45:22
```

## Notes

- Bundles are automatically organized by date and hour
- Use with `/loadbundle` to restore previous session context
- Bundles older than 7 days are automatically cleaned up