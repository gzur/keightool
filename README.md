# keightool (k8-tool)

A Container Image to mess around inside Kubernetes.

See [the Dockerfile](./Dockerfile) for details.

Image is available on Docker Hub as [gzur/keightool](https://hub.docker.com/r/gzur/keightool)


## Changelist

* 0.1.0 - Initial release. Ubuntu containing `curl`
* 0.2.0 - Add `dnsutils`, for `nslookup` et. al
* 0.3.0 - Add netcat