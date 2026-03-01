Class {
	#name : 'LcsGlobalCollectionSlotBuilderExamples',
	#superclass : 'LcsObjectExamples',
	#category : 'Lcs-SlotToolsTests-Examples',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Examples'
}

{ #category : 'tests' }
LcsGlobalCollectionSlotBuilderExamples >> installAndRemoveSlot [
	<gtExample>
	| builder |
	self ensureCurrentSystemIsPrototypeSystem.
	builder := self personsGlobalCollectionSlotBuilder.
	[ builder installCode.
	  builder verifyCodeInstallation ]
		ensure: [ 
			builder uninstall.
			builder verifyUninstall.
			self abortTransaction ]
]

{ #category : 'examples' }
LcsGlobalCollectionSlotBuilderExamples >> newBuilder [
	<gtExample>
	| builder |
	builder :=  LcsGlobalCollectionSlotBuilder new.
	^ builder
]

{ #category : 'examples' }
LcsGlobalCollectionSlotBuilderExamples >> personsGlobalCollectionSlotBuilder [
	<gtExample>
	| builder |
	builder :=   self newBuilder
		slotName: 'foos';
		targetClassName: LxxPrototypeSystem name;
		targetModuleClass: LxxPrototypeSystem name;
		collectionMemberTypes: (OrderedCollection with: LxxPerson);
		addSlotType: LxxPersons;
		yourself.
	builder buildJobSteps.
	^ builder
]

{ #category : 'examples' }
LcsGlobalCollectionSlotBuilderExamples >> slotDefinitionMethodBuilder [
	<gtExample>
	| builder |
	builder := self personsGlobalCollectionSlotBuilder jobStep: 2.
	^ builder
]

{ #category : 'examples' }
LcsGlobalCollectionSlotBuilderExamples >> slotDefinitionSourceCode [
	<gtExample>
	| builder |
	builder :=  self slotDefinitionMethodBuilder.
	self
		assert: builder slotDefinitionSource
		equals: 'foosSlotDefinition
	<accessorSlotDefinition>
	^ LcsGlobalCollectionSlot new
			addSlotType: LxxPersons;
			addCollectionMemberType: LxxPerson;
			slotName: ''foos'';
			yourself'
]
