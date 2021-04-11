#!/usr/bin/env node


const url = require('url');

function base64(string) {
    return Buffer.from(string).toString('base64')
}

function loadProperties() {
    const env = process.env;

    const npmrcProperties = {};

    if (Object.hasOwnProperty.call(env, 'NPM_REGISTRY') || Object.hasOwnProperty.call(env, 'NPM_PASS') || Object.hasOwnProperty.call(env, 'NPM_USER')) {


        let defaultRegistryUrl;
        if (Object.hasOwnProperty.call(env, 'NPM_REGISTRY')) {
            defaultRegistryUrl = new url.URL(env['NPM_REGISTRY'])
        } else {
            defaultRegistryUrl = new url.URL('https://registry.npmjs.org/');
        }

        const defaultRegistryHost = defaultRegistryUrl.hostname;
        const defaultRegistryPath = defaultRegistryUrl.pathname;

        npmrcProperties['registry'] = defaultRegistryUrl.protocol + '//' + defaultRegistryHost + defaultRegistryPath;

        if (defaultRegistryUrl.username) {
            npmrcProperties['//' + defaultRegistryHost + defaultRegistryPath + ':username'] = defaultRegistryUrl.username;
        }
        if (Object.hasOwnProperty.call(env, 'NPM_USER')) {
            npmrcProperties['//' + defaultRegistryHost + defaultRegistryPath + ':username'] = env['NPM_USER'];
        }

        if (defaultRegistryUrl.password) {
            npmrcProperties['//' + defaultRegistryHost + defaultRegistryPath + ':_password'] = base64(defaultRegistryUrl.password);
        }
        if (Object.hasOwnProperty.call(env, 'NPM_PASS')) {
            npmrcProperties['//' + defaultRegistryHost + defaultRegistryPath + ':_password'] = base64(env['NPM_PASS']);
        }
    }

    for (const key in env) {

        if (!key.startsWith('NPM_REGISTRY_')) {
            continue;
        }

        const scope = key.substr(13).toLowerCase();

        if (Object.hasOwnProperty.call(env, key)) {
            const value = env[key];

            const registryUrl = new url.URL(value);

            const registryHost = registryUrl.hostname;
            const registryPath = registryUrl.pathname;

            const username = registryUrl.username;
            const password = registryUrl.password;

            npmrcProperties['@' + scope + ':registry'] = registryUrl.protocol + '//' + registryHost + registryPath;

            if (username) {
                npmrcProperties['//' + registryHost + registryPath + ':username'] = username;
            }
            if (password) {
                npmrcProperties['//' + registryHost + registryPath + ':_password'] = base64(password);
            }
        }
    }
    return npmrcProperties;
}

function propertiesToString(object) {
    let string = '';
    for (const key in object) {
        if (Object.hasOwnProperty.call(object, key)) {
            const value = object[key];
            string += key + '=' + value + "\n";
        }
    }
    return string;
}

const properties = loadProperties();
const propertiesString = propertiesToString(properties);

console.log(propertiesString);