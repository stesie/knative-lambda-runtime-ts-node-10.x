# knative-lambda-runtime-ts-node-10.x

This work is based on [TriggerMesh's KLR](https://github.com/triggermesh/knative-lambda-runtime).

It provides a Node 10.x environment capable of running TypeScript code without
having to compile it beforehand.


## Using it

1. Prepare function code (in `function.ts`)

```
async function justWait() {
  return new Promise((resolve, reject) => setTimeout(resolve, 100));
}

export const handler = async (event: unknown) => {
    await justWait();

    return {
        statusCode: 200,
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
            event
        })
    }
};
```

2. Provide `tsconfig.json`, since we use *es2015* features

```
{
  "compilerOptions": {
    "target": "es5",
    "module": "commonjs",
    "lib": [ "es2015" ],
    "strict": true
  }
}
```

3. Install `@types/node` module

4. Deploy the build template

```
$ tm deploy buildtemplate -f https://raw.githubusercontent.com/stesie/knative-lambda-runtime-ts-node-10.x/master/buildtemplate.yaml
```

5. Deploy function (aka service)

```
$ tm deploy service ts-node-lambda -f . --build-template knative-ts-node10-runtime --env EVENT=API_GATEWAY --wait
```

Profit! :-)

