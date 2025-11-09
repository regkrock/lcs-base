Class {
	#name : #LcsSystemConfigurationClassBuilder,
	#superclass : #LcsDomainClassBuilder,
	#category : #'Lcs-SlotTools'
}

{ #category : #accessing }
LcsSystemConfigurationClassBuilder class >> defaultTargetSuperclassName [
	^ 'LcsBaseConfiguration'
]

{ #category : #command }
LcsSystemConfigurationClassBuilder >> verifySlotModelUpdatesMadeByBuilder [
	super verifySlotModelUpdatesMadeByBuilder.
	"A new system class is not part of the current system's slot model"
	self assert: self installedClass slotModel isNil
]
