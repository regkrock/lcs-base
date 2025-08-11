Class {
	#name : #LcsMissingSlotDefinitionViewItem,
	#superclass : #LcsSlotDefinitionViewItem,
	#instVars : [
		'domainClass'
	],
	#category : #'Lcs-SystemManagement-Core'
}

{ #category : #'as yet unclassified' }
LcsMissingSlotDefinitionViewItem class >> on: anInstVarName domainClass: aClass [
	^ self new 
		initializeOn: anInstVarName domainClass: aClass;
		yourself
]

{ #category : #accessing }
LcsMissingSlotDefinitionViewItem >> domainClass [
	^ domainClass
]

{ #category : #accessing }
LcsMissingSlotDefinitionViewItem >> domainClass: anObject [
	domainClass := anObject
]

{ #category : #asking }
LcsMissingSlotDefinitionViewItem >> getterSelector [
	^ ''
]

{ #category : #'as yet unclassified' }
LcsMissingSlotDefinitionViewItem >> initializeOn: anInstVarName domainClass: aClass [ 
	self instVarName: anInstVarName.
	self domainClass: aClass
]

{ #category : #asking }
LcsMissingSlotDefinitionViewItem >> priority [
	^ ''
]

{ #category : #'slot model' }
LcsMissingSlotDefinitionViewItem >> remove [
	self domainClass removeDomainSlotNamed: self instVarName
]

{ #category : #askingg }
LcsMissingSlotDefinitionViewItem >> setterSelector [
	^ ''
]

{ #category : #'as yet unclassified' }
LcsMissingSlotDefinitionViewItem >> slotDefinitionInformation [
	^ self
]

{ #category : #asking }
LcsMissingSlotDefinitionViewItem >> slotKind [
	^ ''
]

{ #category : #asking }
LcsMissingSlotDefinitionViewItem >> slotName [
	^ 'missing'
]

{ #category : #asking }
LcsMissingSlotDefinitionViewItem >> slotTypesList [
	^ ''
]
