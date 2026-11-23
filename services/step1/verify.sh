#!/bin/bash
# Passes when ~/fleet/den-den-service.yaml exists, and the den-den Service
# selects app=den-den on port 80 to 8000, with 3 pod addresses in its list.
[ -f /root/fleet/den-den-service.yaml ] || exit 1
s() { kubectl get service den-den -o jsonpath="$1" 2>/dev/null; }
[ "$(s '{.spec.selector.app}')" = "den-den" ] || exit 1
[ "$(s '{.spec.ports[0].port}')" = "80" ] || exit 1
[ "$(s '{.spec.ports[0].targetPort}')" = "8000" ] || exit 1
n=$(kubectl get endpointslices -l kubernetes.io/service-name=den-den -o jsonpath='{.items[*].endpoints[*].addresses[*]}' | wc -w)
[ "$n" -eq 3 ]
