{{/*
Expand the name of the chart.
*/}}
{{- define "wsh-java-webservice.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "wsh-java-webservice.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "wsh-java-webservice.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "wsh-java-webservice.labels" -}}
helm.sh/chart: {{ include "wsh-java-webservice.chart" . }}
{{ include "wsh-java-webservice.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "wsh-java-webservice.selectorLabels" -}}
app.kubernetes.io/name: {{ include "wsh-java-webservice.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "wsh-java-webservice.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "wsh-java-webservice.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Context path
*/}}
{{- define "wsh-java-webservice.contextPath" -}}
{{- if .Values.service.contextPath }}
{{- .Values.service.contextPath }}
{{- else }}
{{- printf "/%s" (include "wsh-java-webservice.name" .) }}
{{- end }}
{{- end }}

{{/*
wsh jdbc url template. uniform jdbc parameters for all services.
*/}}
{{- define "wsh-java-webservice.datasourceUrl" -}}
{{- $appName := (include "wsh-java-webservice.name" .) }}
{{- with .Values.datasource }}
{{- if (eq .type "postgres")}}
{{- printf "jdbc:postgresql://%s:5432/%s?autoReconnect=true&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC&rewriteBatchedStatements=true&zeroDateTimeBehavior=convertToNull&stringtype=unspecified&assumeMinServerVersion=10.11&ApplicationName=%s" .hostname .database $appName }}
{{- else if (eq .type "mysql") }}
{{- printf "jdbc:mysql://%s:3306/%s?autoReconnect=true&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC&rewriteBatchedStatements=true&zeroDateTimeBehavior=convertToNull" .hostname .database -}}
{{- else }}
{{- fail (printf "invalid datasource type '%s', allowed values: ['postgres', 'mysql']" .type) }}
{{- end }}
{{- end }}
{{- end }}
