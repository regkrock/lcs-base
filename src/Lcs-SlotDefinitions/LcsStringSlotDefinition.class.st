Class {
	#name : #LcsStringSlotDefinition,
	#superclass : #LcsPrimitiveSlotDefinition,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #initialization }
LcsStringSlotDefinition >> initialize [
	super initialize.
	self addSlotType: self typeClass
]

{ #category : #configuration }
LcsStringSlotDefinition >> typeClass [
	^ LcsSmalltalkConfiguration stringClass
]
