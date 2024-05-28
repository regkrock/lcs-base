Extension { #name : #GtCompositeDefinition }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtCompositeDefinition >> createRefactoringModel [
	^ RBClassModelFactory rbNamespace onEnvironment: RBBrowserEnvironment new
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtCompositeDefinition >> executeRefactoring: arg1 [
	[ arg1 execute ]
		on: RBRefactoringError
		do: [ :arg2 | 
			| tmp1 |
			tmp1 := arg2 messageText.
			(tmp1 endsWith: 'Browse references?') ifTrue: [ tmp1 := tmp1 allButLast: 18 ].
			self inform: tmp1 ]
]
