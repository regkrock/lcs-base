Class {
	#name : 'LcsVirtualSlotExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SlotDefinitionsTests-Examples',
	#package : 'Lcs-SlotDefinitionsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsVirtualSlotExamples >> isInEffectVirtualSlot [
	<gtExample>
	| slot |
	slot := self newSlot.
	slot slotName: 'isInEffect'.
	self assert: slot slotName = 'isInEffect'.	
	slot valueAccessor: '_isInEffect'.
	self assert: slot valueAccessor equals: #'_isInEffect'.
	slot valueAccessor: #dummy.
	self should: [ slot currentSlotVarIn: LcsDateRange new] raise: Error description: 'The #dummy slot does not exist in LcsDateRange'.
	^ slot
]

{ #category : 'examples' }
LcsVirtualSlotExamples >> newSlot [
	<gtExample>
	| slot |
	slot := LcsVirtualSlot new.
	self assert: slot slotName isNil.
	self assert: slot slotTypes isEmpty.
	self assert: slot slotTypes class = OrderedCollection.
	self assert: slot valueAccessor isEmpty.
	self assert: slot isVirtualSlot.
	self
		assert: slot defaultValueAccessBlock printString
		equals: '[ :parentDomainObject :slot | parentDomainObject perform: slot valueAccessor ]'.
	self
		assert: slot valueAccessBlock printString
		equals: '[ :parentDomainObject :slot | parentDomainObject perform: slot valueAccessor ]'.
	self
		should: [ slot slotVarPut: 'anObject' in: LcsDateRange new ]
		raise: Error
		description: 'Updating not allowed'.
	self
		should: [ slot slotVarNamed: 'anObject' in: LcsDateRange new ]
		raise: LcsSlotUpdateNotAllowedError.
	^ slot
]
