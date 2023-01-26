{{- define "myapp.name" -}}
{{- .Release.Name }}-myapp-helm
{{- end }}

{{- define "myapp.labels" }}
  app: myapp
{{- end }}
