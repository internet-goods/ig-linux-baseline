PUT _cluster/settings
{
  "persistent": {
    "cluster.max_shards_per_node": 10000
  }
}

#TODO turn this into a script, run in dev console for now
