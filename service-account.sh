#!/bin/bash

# Create ServiceAccount
kubectl apply -f - <<EOF
apiVersion: v1
kind: ServiceAccount
metadata:
  name: pod-event-logger-sa
  namespace: default
EOF

# Create ClusterRole
kubectl apply -f - <<EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: pod-event-logger-role
rules:
- apiGroups: [""]
  resources: ["pods", "pods/status", "pods/log", "events"]
  verbs: ["get", "list", "watch"]
EOF

# Create ClusterRoleBinding
kubectl apply -f - <<EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: pod-event-logger-rb
subjects:
- kind: ServiceAccount
  name: pod-event-logger-sa
  namespace: default
roleRef:
  kind: ClusterRole
  name: pod-event-logger-role
  apiGroup: rbac.authorization.k8s.io
EOF
