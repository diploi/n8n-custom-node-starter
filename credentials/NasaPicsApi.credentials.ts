import {
  IAuthenticateGeneric,
  ICredentialType,
  INodeProperties,
  IHttpRequestMethods
} from 'n8n-workflow';
export class NasaPicsApi implements ICredentialType {
  name = 'nasaPicsApi';
  displayName = 'NASA Pics API';
  icon = {
    light: 'file:../../icons/diploinode.svg',
    dark: 'file:../../icons/diploinode.svg',
  } as const;
  testedBy = 'nasaPics';
  documentationUrl = 'https://docs.n8n.io/integrations/creating-nodes/build/declarative-style-node/';
  test = {
    request: {
      method: 'GET' as IHttpRequestMethods,
      url: 'https://api.nasa.gov/planetary/apod',
      qs: {
        api_key: '={{$credentials.apiKey}}'
      }
    }
  };
  properties: INodeProperties[] = [
    {
      displayName: 'API key',
      name: 'apiKey',
      type: 'string',
      typeOptions: {
        password: true,
      },
      default: '',
    },
  ];
  authenticate: IAuthenticateGeneric = {
    type: 'generic',
    properties: {
      qs: {
        'api_key': '={{$credentials.apiKey}}'
      }
    },
  };
}