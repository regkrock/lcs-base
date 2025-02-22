Class {
	#name : #LcsMainSystem,
	#superclass : #LcsBaseSystem,
	#category : #'Lcs-MainSystem'
}

{ #category : #'slot definitions' }
LcsMainSystem class >> configurationSlotDefinition [
	"<slotDefinition>
	^ LcsModuleConfigurationSlot newOn: LcsSystemConfiguration"
]

{ #category : #'slot model' }
LcsMainSystem >> systemDomainClasses [
	| collection |
	collection := super systemDomainClasses.
	self addClasses: self class package classes to: collection.
	^ collection
]
