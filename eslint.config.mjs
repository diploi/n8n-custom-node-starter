import { config } from '@n8n/node-cli/eslint';

export default [
	{
		ignores: ['n8n-server/**', 'node_modules/**', 'dist/**', 'icons/**', '.diploi/**', '.github/**'],
	},
	...config,
];
