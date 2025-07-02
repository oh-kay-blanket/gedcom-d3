# gedcom-d3

A parser and converter for GEDCOM (.ged) files, producing D3-capable JSON for genealogy visualization, especially with [3d-force-graph](https://github.com/vasturiano/3d-force-graph).

- **Based on:** [tmcw/parse-gedcom](https://github.com/tmcw/parse-gedcom)
- **See it in action:** [oh-kay-blanket/blood-lines](https://github.com/oh-kay-blanket/blood-lines)

---

## Installation

```sh
npm install --save gedcom-d3
```

---

## API

### `parse(gedcomString)`

- **Input:** A string containing GEDCOM data.
- **Output:** An array of parsed GEDCOM objects (tree structure).

### `d3ize(tree)`

- **Input:** The output of `parse()` (GEDCOM tree array).
- **Output:** An object with the following structure:
  - `nodes`: Array of person nodes, each with properties like `id`, `name`, `surname`, `gender`, `dob`, `yob`, `color`, `bio`, etc.
  - `links`: Array of relationship links (parent/child, spouse, etc.), with `source`, `target`, and relationship type.
  - `families`: Array of family groupings from the GEDCOM data.
  - `surnameList`: Array of unique surnames with color assignments.

---

## Usage Example

```javascript
import { parse, d3ize } from 'gedcom-d3'
import gedcomFile from './gedcoms/sample_ancestors.ged'

const tree = parse(gedcomFile)
const d3Data = d3ize(tree)
// d3Data.nodes and d3Data.links can be fed into 3d-force-graph or similar D3 visualizations
```

---

## Node & Link Structure

### Node (Person)

- `id`: Unique identifier (GEDCOM pointer)
- `name`: Full name
- `firstName`, `surname`: Parsed name parts
- `gender`: 'M' or 'F'
- `dob`, `yob`: Date/year of birth
- `dod`, `yod`: Date/year of death
- `pob`, `pod`: Place of birth/death
- `families`: Array of family objects
- `color`: Assigned color for surname
- `bio`: Biographical notes (if present)
- ...and more, depending on GEDCOM tags

### Link (Relationship)

- `source`: Source person `id`
- `target`: Target person `id`
- `sourceType`, `targetType`: Relationship roles (e.g., 'HUSB', 'WIFE', 'CHIL')
- `type`: Relationship type (e.g., 'MARR', 'DIV', or parentage)

---

## Updating & Publishing the NPM Package

### 1. Make your changes

- Edit code, update version in `package.json` (see [semver](https://semver.org/)).

### 2. Test locally (optional but recommended)

- In another project, run:
  ```sh
  npm install /path/to/gedcom-d3
  ```
- Or use `npm link` for local development.

### 3. Commit and push your changes

```sh
git add .
git commit -m "Describe your changes"
git push
```

### 4. Bump the version

- For a patch, minor, or major update:
  ```sh
  npm version patch   # or 'minor' or 'major'
  git push && git push --tags
  ```

### 5. Publish to NPM

- Log in if you haven't:
  ```sh
  npm login
  ```
- Publish:
  ```sh
  npm publish
  ```
- For scoped packages (not needed here):
  ```sh
  npm publish --access public
  ```

### 6. Verify

- Check your package at [npmjs.com/package/gedcom-d3](https://www.npmjs.com/package/gedcom-d3)

---

## License

ISC

---

## Contributing

Pull requests and issues welcome! See [oh-kay-blanket/gedcom-d3](https://github.com/oh-kay-blanket/gedcom-d3).

---

## Credits

- [tmcw/parse-gedcom](https://github.com/tmcw/parse-gedcom) for the original parser
- [vasturiano/3d-force-graph](https://github.com/vasturiano/3d-force-graph) for visualization inspiration
- [oh-kay-blanket/blood-lines](https://github.com/oh-kay-blanket/blood-lines) for implementation example
