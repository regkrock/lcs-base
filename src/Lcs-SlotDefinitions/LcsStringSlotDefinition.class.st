Class {
	#name : #LcsStringSlotDefinition,
	#superclass : #LcsPrimitiveSlotDefinition,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #accessing }
LcsStringSlotDefinition >> initialize [
	super initialize.
	self addSlotType: self typeClass
]

{ #category : #accessing }
LcsStringSlotDefinition >> typeClass [
	^ LcsSmalltalkConfiguration stringClass
]
