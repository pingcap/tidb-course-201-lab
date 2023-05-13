$ ~/.tiup/bin/tiup ctl:v6.5.1 pd config show all -u http://10.90.2.177:2379
Starting component `ctl`: /home/ec2-user/.tiup/components/ctl/v6.5.1/ctl pd config show all -u http://10.90.2.177:2379
{
  "client-urls": "http://0.0.0.0:2379",
  "peer-urls": "http://0.0.0.0:2380",
  "advertise-client-urls": "http://10.90.1.60:2379",
  "advertise-peer-urls": "http://10.90.1.60:2380",
  "name": "pd-10.90.1.60-2379",
  "data-dir": "/tidb-data/pd-2379",
  "force-new-cluster": false,
  "enable-grpc-gateway": true,
  "initial-cluster": "pd-10.90.3.231-2379=http://10.90.3.231:2380,pd-10.90.1.60-2379=http://10.90.1.60:2380,pd-10.90.2.177-2379=http://10.90.2.177:2380",
  "initial-cluster-state": "new",
  "initial-cluster-token": "pd-cluster",
  "join": "",
  "lease": 3,
  "log": {
    "level": "info",
    "format": "text",
    "disable-timestamp": false,
    "file": {
      "filename": "/tidb-deploy/pd-2379/log/pd.log",
      "max-size": 300,
      "max-days": 0,
      "max-backups": 0
    },
    "development": false,
    "disable-caller": false,
    "disable-stacktrace": false,
    "disable-error-verbose": true,
    "sampling": null,
    "error-output-path": ""
  },
  "tso-save-interval": "3s",
  "tso-update-physical-interval": "50ms",
  "enable-local-tso": false,
  "metric": {
    "job": "pd-10.90.1.60-2379",
    "address": "",
    "interval": "15s"
  },
  "schedule": {
    "max-snapshot-count": 64,
    "max-pending-peer-count": 64,
    "max-merge-region-size": 20,
    "max-merge-region-keys": 200000,
    "split-merge-interval": "1h0m0s",
    "swtich-witness-interval": "1h0m0s",
    "enable-one-way-merge": "false",
    "enable-cross-table-merge": "true",
    "patrol-region-interval": "10ms",
    "max-store-down-time": "30m0s",
    "max-store-preparing-time": "48h0m0s",
    "leader-schedule-limit": 4,
    "leader-schedule-policy": "count",
    "region-schedule-limit": 2048,
    "replica-schedule-limit": 64,
    "merge-schedule-limit": 8,
    "hot-region-schedule-limit": 4,
    "hot-region-cache-hits-threshold": 3,
    "store-limit": {
      "1": {
        "add-peer": 15,
        "remove-peer": 15
      },
      "2": {
        "add-peer": 15,
        "remove-peer": 15
      },
      "4": {
        "add-peer": 15,
        "remove-peer": 15
      }
    },
    "tolerant-size-ratio": 0,
    "low-space-ratio": 0.8,
    "high-space-ratio": 0.7,
    "region-score-formula-version": "v2",
    "scheduler-max-waiting-operator": 5,
    "enable-remove-down-replica": "true",
    "enable-replace-offline-replica": "true",
    "enable-make-up-replica": "true",
    "enable-remove-extra-replica": "true",
    "enable-location-replacement": "true",
    "enable-debug-metrics": "false",
    "enable-joint-consensus": "true",
    "enable-tikv-split-region": "true",
    "schedulers-v2": [
      {
        "type": "balance-region",
        "args": null,
        "disable": false,
        "args-payload": ""
      },
      {
        "type": "balance-leader",
        "args": null,
        "disable": false,
        "args-payload": ""
      },
      {
        "type": "hot-region",
        "args": null,
        "disable": false,
        "args-payload": ""
      },
      {
        "type": "split-bucket",
        "args": null,
        "disable": false,
        "args-payload": ""
      }
    ],
    "schedulers-payload": {
      "balance-hot-region-scheduler": {
        "byte-rate-rank-step-ratio": 0.05,
        "count-rank-step-ratio": 0.01,
        "dst-tolerance-ratio": 1.05,
        "enable-for-tiflash": "true",
        "forbid-rw-type": "none",
        "great-dec-ratio": 0.95,
        "key-rate-rank-step-ratio": 0.05,
        "max-peer-number": 1000,
        "max-zombie-rounds": 3,
        "min-hot-byte-rate": 100,
        "min-hot-key-rate": 10,
        "min-hot-query-rate": 10,
        "minor-dec-ratio": 0.99,
        "query-rate-rank-step-ratio": 0.05,
        "rank-formula-version": "v2",
        "read-priorities": [
          "query",
          "byte"
        ],
        "src-tolerance-ratio": 1.05,
        "strict-picking-store": "true",
        "write-leader-priorities": [
          "query",
          "byte"
        ],
        "write-peer-priorities": [
          "byte",
          "key"
        ]
      },
      "balance-leader-scheduler": {
        "batch": 4,
        "ranges": [
          {
            "end-key": "",
            "start-key": ""
          }
        ]
      },
      "balance-region-scheduler": {
        "name": "balance-region-scheduler",
        "ranges": [
          {
            "end-key": "",
            "start-key": ""
          }
        ]
      },
      "split-bucket-scheduler": null
    },
    "store-limit-mode": "manual",
    "hot-regions-write-interval": "10m0s",
    "hot-regions-reserved-days": 7,
    "enable-diagnostic": "false",
    "enable-witness": "false"
  },
  "replication": {
    "max-replicas": 3,
    "location-labels": "region,zone",
    "strictly-match-label": "false",
    "enable-placement-rules": "true",
    "enable-placement-rules-cache": "false",
    "isolation-level": ""
  },
  "pd-server": {
    "use-region-storage": "true",
    "max-gap-reset-ts": "24h0m0s",
    "key-type": "table",
    "runtime-services": "",
    "metric-storage": "",
    "dashboard-address": "http://10.90.3.231:2379",
    "trace-region-flow": "true",
    "flow-round-by-digit": 3,
    "min-resolved-ts-persistence-interval": "1s"
  },
  "cluster-version": "6.5.1",
  "labels": {},
  "quota-backend-bytes": "8GiB",
  "auto-compaction-mode": "periodic",
  "auto-compaction-retention-v2": "1h",
  "TickInterval": "500ms",
  "ElectionInterval": "3s",
  "PreVote": true,
  "max-request-bytes": 157286400,
  "security": {
    "cacert-path": "",
    "cert-path": "",
    "key-path": "",
    "cert-allowed-cn": null,
    "SSLCABytes": null,
    "SSLCertBytes": null,
    "SSLKEYBytes": null,
    "redact-info-log": false,
    "encryption": {
      "data-encryption-method": "plaintext",
      "data-key-rotation-period": "168h0m0s",
      "master-key": {
        "type": "plaintext",
        "key-id": "",
        "region": "",
        "endpoint": "",
        "path": ""
      }
    }
  },
  "label-property": {},
  "WarningMsgs": [
    "Config contains undefined item: server, server.labels, server.labels.region, server.labels.zone"
  ],
  "DisableStrictReconfigCheck": false,
  "HeartbeatStreamBindInterval": "1m0s",
  "LeaderPriorityCheckInterval": "1m0s",
  "dashboard": {
    "tidb-cacert-path": "",
    "tidb-cert-path": "",
    "tidb-key-path": "",
    "public-path-prefix": "",
    "internal-proxy": false,
    "enable-telemetry": false,
    "enable-experimental": false
  },
  "replication-mode": {
    "replication-mode": "majority",
    "dr-auto-sync": {
      "label-key": "",
      "primary": "",
      "dr": "",
      "primary-replicas": 0,
      "dr-replicas": 0,
      "wait-store-timeout": "1m0s",
      "pause-region-split": "false"
    }
  }
}
