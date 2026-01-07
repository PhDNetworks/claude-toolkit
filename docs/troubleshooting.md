# Troubleshooting

Common issues and solutions.

## Commands Not Found

**Symptom**: `/today` or other commands don't appear in Claude Code

**Solutions**:
1. Check symlinks exist: `ls -la ~/.claude/commands/`
2. Re-run install: `./install.sh`
3. Restart Claude Code session

## Ultrathink Alias Not Working

**Symptom**: `ultrathink` command not found

**Solutions**:
1. Reload shell: `source ~/.zshrc`
2. Check alias: `alias | grep ultrathink`
3. Check PATH includes ~/bin: `echo $PATH`

## MCP Server Errors

### Notion 401 Unauthorized

**Solutions**:
1. Remove old config: `claude mcp remove notion -s user`
2. Follow OAuth setup: https://developers.notion.com/docs/mcp
3. Re-authorize workspace

### Google Calendar No Results

**Solutions**:
1. Check OAuth credentials valid
2. Re-authorize in browser
3. Verify Calendar API enabled in Google Cloud

### Asana Connection Failed

**Solutions**:
1. Verify token at: https://app.asana.com/0/developer-console
2. Re-add with fresh token
3. Check token permissions

## Permission Errors

**Symptom**: "Permission denied" when running scripts

**Solution**:
```bash
chmod +x ~/Projects/claude-toolkit/scripts/*.sh
chmod +x ~/Projects/claude-toolkit/*.sh
```

## Symlink Issues

**Symptom**: Commands point to wrong location or broken

**Solution**:
```bash
# Remove old symlinks
rm ~/.claude/commands/today.md
rm ~/.claude/commands/doc-to-notion.md
rm ~/.claude/commands/ship.md
rm ~/.claude/commands/ultrathink.md

# Re-run install
./install.sh
```

## Shell Not Loading Aliases

**Symptom**: Aliases work in new terminal but not current

**Solution**:
```bash
source ~/.zshrc
# or
exec zsh
```

## Getting Help

If issues persist:
1. Check this file for your error
2. Review install.sh output for errors
3. Check Claude Code logs
4. Open issue on GitHub
