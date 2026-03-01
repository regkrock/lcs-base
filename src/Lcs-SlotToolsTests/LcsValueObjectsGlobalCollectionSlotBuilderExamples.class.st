Class {
	#name : 'LcsValueObjectsGlobalCollectionSlotBuilderExamples',
	#superclass : 'LcsObjectExamples',
	#category : 'Lcs-SlotToolsTests-Examples',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsValueObjectsGlobalCollectionSlotBuilderExamples >> newBuilder [
	<gtExample>
	| builder |
	builder := LcsValueObjectsGlobalCollectionSlotBuilder new.
	self assert: builder class slotClass equals: LcsValueObjectsGlobalCollectionSlot.
	self assert: builder slotClassName  equals: 'LcsValueObjectsGlobalCollectionSlot'.
	self assert: builder collectionClass equals: IdentitySet.
	self assert: builder parent isNil.
	self assert: builder jobSteps hasNoJobSteps.
	self assert: builder collectionMemberTypes isEmpty.
	self assert: builder loaderClassName isNil.
	self assert: builder refactorings isEmpty.
	self assert: builder slotClass isNil.
	self assert: builder slotDefinitionSelector isNil.
	self assert: builder slotTypeClassName isNil.
	self assert: builder slotTypes isEmpty.
	self assert: builder state = 'Initial'.
	self assert: builder targetClass isNil.
	self assert: builder targetClassName isNil.
	self assert: builder targetModule isNil.
	self assert: builder targetModuleClass isNil.
	self assert: builder targetModuleName isNil.
	builder slotName: 'foo'.	
	self assert: builder slotName = 'foo'.
	self assert: builder slotDefinitionSelector equals: 'fooSlotDefinition'.
	builder slotName: 'Foo'.
	self assert: builder slotName equals: 'foo'.
	self assert: builder slotDefinitionSelector = 'fooSlotDefinition'.
	builder slotName: 'FooBar'.
	self assert: builder slotName = 'fooBar'.
	self assert: builder slotDefinitionSelector equals: 'fooBarSlotDefinition'.
	builder slotName: nil.
	
	builder targetClassName: 'FooBar'.
	self assert: builder targetClassName equals:'FooBar'.
	self assert: builder targetClass isNil.
	builder targetClassName: nil.
	self assert: builder targetClassName isNil.
	self assert: builder targetClass isNil.

	^ builder
]

{ #category : 'examples' }
LcsValueObjectsGlobalCollectionSlotBuilderExamples >> slotDefinitionAccessorMethodBuilder [
	<gtExample>
	| builder |
	builder := self slotDefinitionBuilderWithSlotName jobStep: 3.
	^ builder
]

{ #category : 'examples' }
LcsValueObjectsGlobalCollectionSlotBuilderExamples >> slotDefinitionAccessorMethods [
	<gtExample>
	| builder |
	builder := self slotDefinitionAccessorMethodBuilder.
	self assert: builder refactoringText equals: 'fooBars
	^ self slotVarNamed: ''fooBars''

fooBars: anObject
	self slotVarNamed: ''fooBars'' put: anObject'.	
	^ builder refactoringText
]

{ #category : 'examples' }
LcsValueObjectsGlobalCollectionSlotBuilderExamples >> slotDefinitionBuilderWithSlotName [
	<gtExample>
	| builder |
	builder := self newBuilder
					slotName: 'fooBars';
					targetClassName: #LxxPrototypeSystem;
					targetModuleClass: LxxPrototypeSystem;
					loaderClassName: 'LcsFooBarLoader';
					addCollectionMemberType: 'LcsFooBar';
					addSlotType: LxxPerson;
					yourself.
	builder buildJobSteps.
	self assert: builder jobSteps numberOfSteps = 3.
	^ builder
]

{ #category : 'examples' }
LcsValueObjectsGlobalCollectionSlotBuilderExamples >> slotDefinitionInstanceBuilder [
	<gtExample>
	| builder |
	builder := self slotDefinitionBuilderWithSlotName jobStep: 1.
	self assert: builder refactoringText equals: 'LxxPrototypeSystem - add instanceVariable: fooBars'.
	^ builder
]

{ #category : 'examples' }
LcsValueObjectsGlobalCollectionSlotBuilderExamples >> slotDefinitionMethodBuilder [
	<gtExample>
	| builder |
	builder := self slotDefinitionBuilderWithSlotName jobStep: 2.
	^ builder
]

{ #category : 'examples' }
LcsValueObjectsGlobalCollectionSlotBuilderExamples >> slotDefinitionMethodSourceCode [
	<gtExample>
	| builder |
	builder := self slotDefinitionMethodBuilder.
	self assert: builder refactoringText equals: 'LxxPrototypeSystem class >>fooBarsSlotDefinition
	<accessorSlotDefinition>
	^ LcsValueObjectsGlobalCollectionSlot new
			addSlotType: LxxPerson;
			addCollectionMemberType: LcsFooBar;
			slotName: ''fooBars'';
			loaderClass: ''LcsFooBarLoader'';
			yourself'.
	^ builder refactoringText
]
