# keightool (k8-tool)

A Container Image to mess around inside Kubernetes.

See [the Dockerfile](./Dockerfile) for details.

Image is available on Docker Hub as [gzur/keightool](https://hub.docker.com/r/gzur/keightool)


## Contributing
1. Make a change
1. Bump the [VERSION](./VERSION) file
1. Commit changes
1. `make release`

## Changelist

* 0.1.0 - Initial release. Ubuntu containing `curl`
* 0.2.0 - Add `dnsutils`, for `nslookup` et. al
* 0.3.0 - Add netcat
* 0.4.0 - Add jq
* 1.0.0 - Make fish the default shell