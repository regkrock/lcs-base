Extension { #name : #RBRefactoryChange }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
RBRefactoryChange >> gtExecuteWithNotification [
	^ self gtExecuteWithNotificationWithProgress: [  ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
RBRefactoryChange >> gtExecuteWithNotificationWithProgress: arg1 [
	| tmp1 tmp2 |
	tmp1 := self gtCompilationJobWithProgress: arg1.
	tmp2 := GtCompilationNotificationJob new.
	tmp2
		job: tmp1;
		registerNotifications.
	^ [ tmp1 run ] asAsyncPromise
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
RBRefactoryChange >> recursivelyRemoveChange: arg1 [
	
]
