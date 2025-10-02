Class {
	#name : #LcsLegalEntity,
	#superclass : #LcsDomainObject,
	#category : #'Lcs-LegalEntities'
}

{ #category : #'slot definitions' }
LcsLegalEntity class >> entityNameSlotDefinition [
	<virtualSlotDefinition>
	^ LcsVirtualSlot new
		slotName: 'entityName';
		valueAccessor: #fullName;
		yourself
]

{ #category : #accessing }
LcsLegalEntity >> entityName [
	^ self virtualSlotVarNamed: 'entityName'
]
