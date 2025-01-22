Extension { #name : #LcsSystemsManager }

{ #category : #'*Lcs-DomainBase' }
LcsSystemsManager >> availableSystemClasses [
	^ LcsBaseSystem allSubclasses
		select: [ :eachClass | eachClass subclasses isEmpty ]
]
