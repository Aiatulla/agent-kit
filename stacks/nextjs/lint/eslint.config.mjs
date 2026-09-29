// agent-kit preset for the nextjs stack (ESLint 9+ flat config, core rules only).
// Use it next to the project's own config, for example:
//   import agentKit from "./.agent-kit/stacks/nextjs/lint/eslint.config.mjs";
//   export default [...nextConfig, ...agentKit];
const HEX = "^#([0-9a-fA-F]{3,4}|[0-9a-fA-F]{6}|[0-9a-fA-F]{8})$";
const ARBITRARY_HEX = "\\[#[0-9a-fA-F]{3,8}\\]";

export default [
  {
    files: ["**/*.{ts,tsx,js,jsx,mjs}"],
    rules: {
      "max-lines": ["error", { max: 200, skipBlankLines: true, skipComments: true }],
      "no-restricted-imports": ["error", {
        patterns: [{ regex: "^\\.\\./", message: "Use the @/ absolute import instead of a parent-relative path." }],
      }],
      "no-restricted-globals": ["error", {
        name: "fetch",
        message: "Call the backend through the API client module (lib/api), not fetch directly.",
      }],
      "no-restricted-syntax": ["error",
        { selector: `Literal[value=/${HEX}/]`, message: "Use a design token (CSS variable), not a hex color." },
        { selector: `Literal[value=/${ARBITRARY_HEX}/]`, message: "Use a design token (CSS variable), not an arbitrary hex value." },
        { selector: `TemplateElement[value.raw=/${ARBITRARY_HEX}/]`, message: "Use a design token (CSS variable), not an arbitrary hex value." },
      ],
    },
  },
  {
    // The API client is the one place allowed to call fetch.
    files: ["**/lib/api.{ts,js}", "**/lib/api/**"],
    rules: { "no-restricted-globals": "off" },
  },
  {
    files: ["**/*.config.{ts,js,mjs}", "**/*.{test,spec}.{ts,tsx}"],
    rules: { "no-restricted-imports": "off", "max-lines": "off" },
  },
];
