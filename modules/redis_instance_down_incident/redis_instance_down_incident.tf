resource "shoreline_notebook" "redis_instance_down_incident" {
  name       = "redis_instance_down_incident"
  data       = file("${path.module}/data/redis_instance_down_incident.json")
  depends_on = [shoreline_action.invoke_redis_monitor,shoreline_action.invoke_redis_log_tail]
}

resource "shoreline_file" "redis_monitor" {
  name             = "redis_monitor"
  input_file       = "${path.module}/data/redis_monitor.sh"
  md5              = filemd5("${path.module}/data/redis_monitor.sh")
  description      = "Redis server might have been facing heavy load or high traffic, causing it to crash or become unresponsive."
  destination_path = "/agent/scripts/redis_monitor.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_file" "redis_log_tail" {
  name             = "redis_log_tail"
  input_file       = "${path.module}/data/redis_log_tail.sh"
  md5              = filemd5("${path.module}/data/redis_log_tail.sh")
  description      = "Check the Redis server logs to understand the root cause of the issue."
  destination_path = "/agent/scripts/redis_log_tail.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_redis_monitor" {
  name        = "invoke_redis_monitor"
  description = "Redis server might have been facing heavy load or high traffic, causing it to crash or become unresponsive."
  command     = "`chmod +x /agent/scripts/redis_monitor.sh && /agent/scripts/redis_monitor.sh`"
  params      = []
  file_deps   = ["redis_monitor"]
  enabled     = true
  depends_on  = [shoreline_file.redis_monitor]
}

resource "shoreline_action" "invoke_redis_log_tail" {
  name        = "invoke_redis_log_tail"
  description = "Check the Redis server logs to understand the root cause of the issue."
  command     = "`chmod +x /agent/scripts/redis_log_tail.sh && /agent/scripts/redis_log_tail.sh`"
  params      = ["PATH_TO_REDIS_LOG_FILE"]
  file_deps   = ["redis_log_tail"]
  enabled     = true
  depends_on  = [shoreline_file.redis_log_tail]
}

