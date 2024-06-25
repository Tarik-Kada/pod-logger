import os
import time
import logging
from kubernetes import client, config, watch

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s.%(msecs)03d %(message)s', datefmt='%Y-%m-%d %H:%M:%S')

def log_event(event_type, pod):
    pod_name = pod.metadata.name
    namespace = pod.metadata.namespace
    node_name = pod.spec.node_name
    timestamp = time.time()

    logging.info(f"Event: {event_type}, Pod: {pod_name}, Namespace: {namespace}, Node: {node_name}, Timestamp: {timestamp}")

def main():
    config.load_incluster_config()
    v1 = client.CoreV1Api()
    w = watch.Watch()

    for event in w.stream(v1.list_pod_for_all_namespaces):
        event_type = event['type']
        pod = event['object']

        if event_type == "ADDED":
            log_event("Pod Created", pod)
        elif event_type == "MODIFIED" and pod.spec.node_name:
            log_event("Pod Scheduled", pod)

if __name__ == '__main__':
    main()
