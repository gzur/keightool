# keightool (k8-tool) - the 'k' stands for kowboy 🤠

A [Container Image](./Dockerfile) and [YAML](./yaml/keightool.yaml) to mess around inside Kubernetes.

## What's included?

* `git`
* `fish` shell
* `openssh-client`
* `curl`
* `dnsutils`
* `jq`
* `netcat`
* `tcpdump`

The most up-to-date list can be found inside [the Dockerfile](./Dockerfile#L23-27)

The Docker Image is available on Docker Hub as [gzur/keightool](https://hub.docker.com/r/gzur/keightool)

## Installation

### The yeehaaw way

1. ```.bash
   NAMESPACE=default kubectl apply --namespace $NAMESPACE -f https://raw.githubusercontent.com/gzur/keightool/main/yaml/keightool.yaml
   ```

2. ```.bash
   NAMESPACE=default kubectl exec --namespace $NAMESPACE -it $(kubectl get pods -l app=keightool -o jsonpath='{@.items[0].metadata.name}') -- bash
   ```

3. You should now be in an interactive a shell, running in a pod, inside your cluster.

## The other way

#### Pre-requisites

* An active kube context against the cluster you're cowboying 🤠
* `kubectl`

### Installing via `make`

1. Clone this repo.

2. Make sure your `kubecontext` is pointing towards the `namespace` you want to install into.

3. ```.bash
   make k8s.up 
   ```

### Uninstalling via `make`

1. Make sure your `kubecontext` is pointing towards the `namespace` you installed `keightool` into.

2. ```.bash
   make k8s.down 
   ```

### Usage via `make`

```.bash
make k8s.shell
```

You should now have a shell inside the running keightool pod.

### Press `Ctrl-D` to exit the pod  

## Contributing

1. Fork
1. Make a change.
1. Bump the [VERSION](./VERSION) - let [SemVer](https://semver.org/) guide your way.
1. Create a Pull Request

## Releasing

1. Push a tag which matches the content of the [VERSION](./VERSION) file.
1. Github Actions takes care of the rest.
