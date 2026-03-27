Class {
	#name : 'LcsMemberOfGlobalCollectionSlotExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SystemManagementTests-Examples',
	#package : 'Lcs-SystemManagementTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsMemberOfGlobalCollectionSlotExamples >> newSlot [
	<gtExample>
	| slot |
	slot := LcsMemberOfGlobalCollectionSlot new.
	self assert: slot slotName isNil.
	self assert: slot collectionSlotModuleName isNil.
	self assert: slot collectionSlotName isNil.
	"Note: The next two assertions may fail with an Error"
	self should: [ self assert: slot targetCollection ] raise: LcsError.
	self should: [ slot defaultInstance ] raise: LcsError.
	^ slot
]
