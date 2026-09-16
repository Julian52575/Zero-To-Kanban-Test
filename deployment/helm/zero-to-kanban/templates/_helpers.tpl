{{/* Base name for chart resources */}}
{{- define "zero-to-kanban.name" -}}
{{- .Chart.Name -}}
{{- end -}}

{{/* Fully qualified app name, e.g. <release>-zero-to-kanban */}}
{{- define "zero-to-kanban.fullname" -}}
{{- printf "%s-%s" .Release.Name (include "zero-to-kanban.name" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Common labels */}}
{{- define "zero-to-kanban.labels" -}}
app.kubernetes.io/name: {{ include "zero-to-kanban.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/* Hostname of the postgresql subchart's primary Service */}}
{{- define "zero-to-kanban.postgresql.host" -}}
{{- printf "%s-postgresql" .Release.Name -}}
{{- end -}}

{{/*
Name of the Secret holding the Postgres password.
- If postgresql.auth.existingSecret is set (prod), use that pre-created
  Secret directly -- nothing here ever sees the password.
- Otherwise (dev), fall back to the Secret the bitnami postgresql subchart
  generates itself from postgresql.auth.password.
*/}}
{{- define "zero-to-kanban.postgresql.secretName" -}}
{{- if .Values.postgresql.auth.existingSecret -}}
{{- .Values.postgresql.auth.existingSecret -}}
{{- else -}}
{{- include "zero-to-kanban.postgresql.host" . -}}
{{- end -}}
{{- end -}}

{{/* Key within that Secret that holds the password */}}
{{- define "zero-to-kanban.postgresql.secretKey" -}}
{{- .Values.postgresql.auth.secretKeys.userPasswordKey | default "password" -}}
{{- end -}}
