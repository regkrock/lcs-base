"
These are support classes which have a slot model but are not part of the domain model.
"
Class {
	#name : #LcsSupportDomainObject,
	#superclass : #LcsBaseDomainObject,
	#category : #'Lcs-SystemManagement-Domain'
}

{ #category : #'slot definitions\t' }
LcsSupportDomainObject class >> parentSlotDefinition [
	<slotDefinition>
	^ super parentSlotDefinition
		makeDirectVariableUpdate;
		yourself

]

{ #category : #testing }
LcsSupportDomainObject >> isSupportDomainObject [
	^ true
]
