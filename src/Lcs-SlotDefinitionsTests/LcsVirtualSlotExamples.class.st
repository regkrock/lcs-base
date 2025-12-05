Class {
	#name : 'LcsVirtualSlotExamples',
	#superclass : 'LcsObjectExamples',
	#category : 'Lcs-SlotDefinitionsTests-Examples',
	#package : 'Lcs-SlotDefinitionsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsVirtualSlotExamples >> isInEffectVirtualSlot [
	<gtExample>
	| slot |
	slot := self virtualSlot.
	slot slotName: 'isInEffect'.
	self assert: slot slotName = 'isInEffect'.	
	slot valueAccessor: '_isInEffect'.
	self assert: slot valueAccessor equals: #'_isInEffect'.
	^ slot
]

{ #category : 'examples' }
LcsVirtualSlotExamples >> virtualSlot [
	<gtExample>
	| slot |
	slot := LcsVirtualSlot new.

	self assert: slot slotName isNil.
	self assert: slot slotTypes isEmpty.
	self assert: slot slotTypes class = OrderedCollection.
	self assert: slot valueAccessor isNil.

	self
		assert: slot defaultValueAccessBlock printString
		equals: '[ :parentDomainObject :slot | parentDomainObject perform: slot valueAccessor ]'.
	self assert: slot valueAccessBlock printString equals: '[ :parentDomainObject :slot | parentDomainObject perform: slot valueAccessor ]'.
		
	^ slot
]
