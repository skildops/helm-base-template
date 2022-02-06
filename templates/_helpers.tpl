{{/*
Project Name
*/}}
{{- define "project" -}}
{{- default "skildops" .Values.global.projectName -}}
{{- end -}}

{{/*
Environment
*/}}
{{- define "environment" -}}
{{- default "dev" .Values.global.environment -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "global.labels" -}}
helm.sh/chart: {{ .Chart.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/release: {{ .Release.Name }}
{{- range $key, $value := .Values.global.labels }}
{{ $key }}: {{ $value | quote }}
{{- end }}
{{- end -}}

{{/*
Base fullname
*/}}
{{- define "base.fullname" -}}
{{- printf "%s-%s" (include "project" .) (.Chart.Name) | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{/*
Create a default fully qualified deployment name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "deployment.fullname" -}}
{{- printf "%s-%s" (include "base.fullname" .) .Values.deployment.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Deployment labels
*/}}
{{- define "deployment.labels" -}}
{{ include "global.labels" . }}
{{- range $key, $value := .Values.deployment.labels }}
{{ $key }}: {{ $value | quote }}
{{- end }}
{{- end -}}

{{/*
Deployment Selector labels
*/}}
{{- define "deployment.selectorLabels" -}}
app.kubernetes.io/name: {{ include "deployment.fullname" . }}
{{- range $key, $value := .Values.deployment.selectorLabels }}
{{ $key }}: {{ $value | quote }}
{{- end }}
{{- end -}}


{{/*
ConfigMap labels
*/}}
{{- define "configMap.labels" -}}
{{ include "global.labels" . }}
{{- range $key, $value := .Values.configMap.labels }}
{{ $key }}: {{ $value | quote }}
{{- end }}
{{- end -}}

{{/*
Create a default fully qualified configMap name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "configMap.fullname" -}}
{{- printf "%s-%s" (include "base.fullname" .) .Values.configMap.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{/*
Secret labels
*/}}
{{- define "secret.labels" -}}
{{ include "global.labels" . }}
{{- range $key, $value := .Values.secret.labels }}
{{ $key }}: {{ $value | quote }}
{{- end }}
{{- end -}}

{{/*
Create a default fully qualified secret name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "secret.fullname" -}}
{{- printf "%s-%s" (include "base.fullname" .) .Values.secret.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{/*
Create a default fully qualified hpa name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "hpa.fullname" -}}
{{- printf "%s-%s" (include "base.fullname" .) .Values.hpa.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{/*
Service labels
*/}}
{{- define "service.labels" -}}
{{ include "global.labels" . }}
{{- range $key, $value := .Values.deployment.service.labels }}
{{ $key }}: {{ $value | quote }}
{{- end }}
{{- end -}}


{{/*
Ingress labels
*/}}
{{- define "ingress.labels" -}}
{{ include "global.labels" . }}
{{- range $key, $value := .Values.deployment.ingress.labels }}
{{ $key }}: {{ $value | quote }}
{{- end }}
{{- end -}}


{{/*
Service Account labels
*/}}
{{- define "serviceAccount.labels" -}}
{{ include "global.labels" . }}
{{- range $key, $value := .Values.deployment.serviceAccount.labels }}
{{ $key }}: {{ $value | quote }}
{{- end }}
{{- end -}}




# {{- define "baseDomain" -}}
# {{- if eq .Values.environment "production" -}}
#   {{- printf "%s.%s.planetrics.com" (include "client" .) (include "project" .) -}}
# {{- else -}}
#   {{- printf "%s.%s.%s.planetrics.com" (include "client" .) (include "environment" .) (include "project" .) -}}
# {{- end -}}
# {{- end -}}
