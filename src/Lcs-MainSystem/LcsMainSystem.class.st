Class {
	#name : #LcsMainSystem,
	#superclass : #LcsSystem,
	#category : #'Lcs-MainSystem'
}

{ #category : #'slot definitions' }
LcsMainSystem class >> configurationSlotDefinition [
	"<slotDefinition>
	^ LcsModuleConfigurationSlot newOn: LcsSystemConfiguration"
]

{ #category : #'as yet unclassified' }
LcsMainSystem >> loadData [
	LcsCountryLoader new load.
	self applyChanges
]

{ #category : #'slot model' }
LcsMainSystem >> systemDomainClasses [
	| collection |
	collection := super systemDomainClasses.
	self addClasses: self class package classes to: collection.
	^ collection
]
