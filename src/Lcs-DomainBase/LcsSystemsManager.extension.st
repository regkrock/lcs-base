Extension { #name : #LcsSystemsManager }

{ #category : #'*Lcs-DomainBase' }
LcsSystemsManager >> availableSystemClasses [
	^ LcsSystem allSubclasses
		select: [ :eachClass | eachClass subclasses isEmpty ]
]
