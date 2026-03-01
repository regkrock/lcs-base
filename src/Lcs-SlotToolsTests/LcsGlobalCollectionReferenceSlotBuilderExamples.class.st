Class {
	#name : 'LcsGlobalCollectionReferenceSlotBuilderExamples',
	#superclass : 'LcsObjectExamples',
	#category : 'Lcs-SlotToolsTests-Examples',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsGlobalCollectionReferenceSlotBuilderExamples >> builderWithReferenceToPersonsGlobalCollection [
	<gtExample>
	| builder |
	builder := self newBuilder
		slotName: 'parent';
		collectionSlotModuleName: LxxPrototypeSystem defaultModuleName;
		addSlotType: LxxPersons;
		collectionSlotName: 'persons';
		yourself.
	builder buildJobSteps.
		
	self assert: builder slotName = 'parent'.
	self assert: builder collectionSlotModuleName equals: LxxPrototypeSystem defaultModuleName.
	self assert: (builder slotTypes includes: LxxPersons).
	self assert: builder collectionSlotName equals: 'persons'.
	^ builder
]

{ #category : 'examples' }
LcsGlobalCollectionReferenceSlotBuilderExamples >> newBuilder [
	<gtExample>
	| builder |
	builder := LcsGlobalCollectionReferenceSlotBuilder new.
	self assert: builder class slotClass equals: LcsGlobalCollectionReferenceSlot.
	^ builder
]

{ #category : 'examples' }
LcsGlobalCollectionReferenceSlotBuilderExamples >> slotDefinitionMethodBuilder [
	<gtExample>
	| slotDefinitionBuilder |
	slotDefinitionBuilder := self builderWithReferenceToPersonsGlobalCollection jobStep: 2.
	^ slotDefinitionBuilder
]

{ #category : 'examples' }
LcsGlobalCollectionReferenceSlotBuilderExamples >> slotDefinitionMethodSourceCode [
	<gtExample>
	| builder |
	builder := self slotDefinitionMethodBuilder.
	self assert: builder slotDefinitionSource equals: 
'parentSlotDefinition
	<accessorSlotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
			addSlotType: LxxPersons;
			slotName: ''parent'';
			collectionSlotModuleName: ''Prototype System'';
			collectionSlotName: ''persons'';
			yourself'
]
