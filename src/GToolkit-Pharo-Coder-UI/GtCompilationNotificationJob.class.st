Class {
	#name : #GtCompilationNotificationJob,
	#superclass : #GtNotificationJob,
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings'
}

{ #category : #accessing }
GtCompilationNotificationJob >> registerNotifications [
	GtWorld allInstancesDo: [ :arg1 | arg1 showNotification: self ]
]

{ #category : #accessing }
GtCompilationNotificationJob >> summaryClass [
	^ GtCompilationNotificationSummary
]
