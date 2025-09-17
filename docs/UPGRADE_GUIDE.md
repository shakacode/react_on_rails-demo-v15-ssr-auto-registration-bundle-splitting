# React on Rails Upgrade Guide

This guide provides step-by-step instructions for upgrading React on Rails to newer versions, with specific focus on major version upgrades.

## General Upgrade Process

### 1. Update Dependencies

**Gemfile:**
```ruby
# Update to latest version
gem "react_on_rails", "~> 16.0"
```

**package.json:**
```json
{
  "dependencies": {
    "react-on-rails": "^16.0.0"
  }
}
```

### 2. Install Updates

```bash
bundle update react_on_rails
npm install
```

### 3. Run Generator for Latest Defaults

**⚠️ Important:** Always run the generator after major version upgrades:

```bash
rails generate react_on_rails:install
```

This command updates:
- `bin/dev` (improved development workflow)
- webpack configurations
- `shakapacker.yml` settings
- other configuration files

### 4. Review and Apply Changes

**Carefully review** all generated changes before applying them:

```bash
# Check what files would be modified
git status

# Review specific changes
git diff config/webpack/
git diff config/shakapacker.yml
git diff bin/dev
```

**Apply changes selectively** to avoid overwriting custom configurations:
- Keep your custom webpack configurations
- Preserve any custom development workflows
- Maintain project-specific settings

### 5. Test Thoroughly

```bash
# Test asset compilation
bundle exec rails assets:precompile

# Test development server
bin/dev

# Test different development modes
bin/dev static
bin/dev prod

# Run your test suite
bundle exec rspec # or your test command
```

## Version-Specific Upgrade Instructions

### Upgrading to v16.0.0

#### Breaking Changes
- **Webpacker Dependency Removal**: React on Rails v16 removed webpacker as a dependency
- **Shakapacker Migration**: Must use Shakapacker instead of webpacker
- **Function Parameter Changes**: React Hooks compatibility improvements
- **Mini Racer Removal**: No longer includes mini_racer by default

#### Migration Steps

1. **Update Dependencies** (as described above)

2. **Webpack Configuration Updates**:
   - Function names may need updating (`generateWebpackConfigs` → `webpackConfig`)
   - Review webpack configuration exports

3. **Shakapacker Configuration**:
   - Ensure `shakapacker.yml` has appropriate settings
   - Review compilation strategies (`digest` vs `mtime`)

4. **React Hooks Compatibility**:
   - Functions with 0-1 params: No migration needed
   - Functions with 2+ params: May need syntax updates
   - Check for function component parameter handling

#### Compatibility Notes
- ✅ React 19 support maintained
- ✅ Shakapacker 8.3+ compatibility
- ✅ File-system-based auto-registration continues to work
- ✅ Bundle splitting functionality preserved
- ✅ SSR functionality maintained

### Upgrading from v15.x

#### New Features in v16
- Enhanced React 19 support
- Improved development tooling
- Better Shakapacker integration
- Updated generator templates

#### Migration Checklist
- [ ] Update Gemfile and package.json versions
- [ ] Run `bundle update react_on_rails`
- [ ] Run `npm install`
- [ ] Run `rails generate react_on_rails:install`
- [ ] Review and apply generated changes
- [ ] Test all development modes (`bin/dev`, `bin/dev static`, `bin/dev prod`)
- [ ] Test asset compilation in production
- [ ] Run full test suite
- [ ] Deploy to staging environment for testing

## Troubleshooting Common Issues

### "package.json not found" Error

**Problem**: Generator fails during installation.

**Solution**: Ensure proper installation sequence:
1. Install Shakapacker first: `bundle add shakapacker`
2. Then install React on Rails: `bundle add react_on_rails`
3. Run generators: `rails generate react_on_rails:install`

### Webpack Configuration Errors

**Problem**: Function name mismatches in webpack configs.

**Solution**: Check webpack configuration exports:
```javascript
// Ensure function names match expected patterns
const webpackConfig = (envSpecific) => {
  // ... configuration
};

module.exports = webpackConfig;
```

### Bundle Compilation Failures

**Problem**: Assets fail to compile after upgrade.

**Solution**:
1. Clear webpack cache: `rm -rf tmp/cache/shakapacker`
2. Regenerate packs: `bundle exec rake react_on_rails:generate_packs`
3. Precompile assets: `bundle exec rails assets:precompile`

### Development Server Issues

**Problem**: `bin/dev` commands not working as expected.

**Solution**:
1. Regenerate `bin/dev`: Run the generator and apply bin/dev changes
2. Check Procfile configurations
3. Verify port availability: `bin/dev kill` to clean up processes

## Best Practices

### Before Upgrading
1. **Backup your project**: Commit all changes and create a backup
2. **Test in development**: Never upgrade directly in production
3. **Read release notes**: Check the official changelog for breaking changes
4. **Update gradually**: Consider incremental updates for large version jumps

### During Upgrade
1. **Review all changes**: Don't blindly accept generator changes
2. **Preserve customizations**: Keep your project-specific configurations
3. **Test incrementally**: Test each major change separately
4. **Document changes**: Note any manual modifications needed

### After Upgrading
1. **Full testing**: Test all application features thoroughly
2. **Performance check**: Verify bundle sizes and loading times
3. **Deploy to staging**: Test in production-like environment
4. **Monitor deployment**: Watch for issues after production deployment

## Getting Help

If you encounter issues during upgrade:

1. **Check Documentation**: Visit [React on Rails docs](https://www.shakacode.com/react-on-rails/docs/)
2. **Review Changelog**: Check the official changelog for known issues
3. **Search Issues**: Look for similar problems in the GitHub repository
4. **Ask for Help**: Create an issue with detailed error information
5. **Professional Support**: Consider [React on Rails Pro](https://www.shakacode.com/react-on-rails-pro) for expert assistance

## Additional Resources

- [React on Rails Documentation](https://shakacode.gitbook.io/react-on-rails/)
- [Shakapacker Documentation](https://github.com/shakacode/shakapacker)
- [React on Rails Pro](https://www.shakacode.com/react-on-rails-pro)
- [Official GitHub Repository](https://github.com/shakacode/react_on_rails)
- [Community Discussions](https://github.com/shakacode/react_on_rails/discussions)