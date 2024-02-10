Class {
	#name : #LcsLegalEntity,
	#superclass : #LcsDomainObject,
	#instVars : [
		'entityName'
	],
	#category : #'Lcs-LegalEntities'
}

{ #category : #accessing }
LcsLegalEntity class >> slotDefinitionFor: aSlotName [ 
	^self slotDefinitions slotDefinitionFor: aSlotName 
]

{ #category : #accessing }
LcsLegalEntity >> entityName [
	^entityName
]

{ #category : #accessing }
LcsLegalEntity >> entityName: aString [ 
	entityName := aString
]

{ #category : #accessing }
LcsLegalEntity >> inSlotFor: aSlotName put: anObject [
	(self slotDefinitionFor: aSlotName) setSlotValueTo: anObject
	
]

{ #category : #accessing }
LcsLegalEntity >> slotDefinitionFor: aSlotName [ 
	^self class slotDefinitionFor: aSlotName
]
