"
These are support classes which have a slot model but are not part of the domain model.
"
Class {
	#name : 'LcsSupportDomainObject',
	#superclass : 'LcsBaseDomainObject',
	#category : 'Lcs-SystemManagement-Domain',
	#package : 'Lcs-SystemManagement',
	#tag : 'Domain'
}

{ #category : 'slot definitions\t' }
LcsSupportDomainObject class >> parentSlotDefinition [
	<slotDefinition>
	^ super parentSlotDefinition
			makeDirectUpdateOfVariable;
			yourself

]

{ #category : 'testing' }
LcsSupportDomainObject >> isSupportDomainObject [
	^ true
]
