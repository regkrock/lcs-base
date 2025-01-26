Class {
	#name : #LcsPrimitiveSlotDefinitionBuilderTest,
	#superclass : #LcsSlotDefinitionBuilderTest,
	#instVars : [
		'initialValue',
		'slotName',
		'targetClass',
		'slotBuilderClass'
	],
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #tests }
LcsPrimitiveSlotDefinitionBuilderTest >> buildAndInstallNewSlot [
	| builder |
	self removeArtifactsRelatedToSlot.

	builder := self slotBuilderClass new
			targetClassName: self targetClass name asString;
			slotName: self slotName.

	self assert: builder slotName equals: self slotName.
	self assert: builder targetClassName equals: self targetClass name asString.
	self assert: builder target equals: self targetClass.
	self
		assert: builder slotDefinitionSelector
		equals: self slotName , 'SlotDefinition'.

	builder installCode.
	builder verifyCodeInstallation.

	self targetClass verifyClassHasDomainSlotNamed: self slotName.

	builder updateSlotModel.
	builder verifySlotModelUpdatesMadeByBuilder
]

{ #category : #tests }
LcsPrimitiveSlotDefinitionBuilderTest >> initialValue [
	^ initialValue
]

{ #category : #tests }
LcsPrimitiveSlotDefinitionBuilderTest >> initialValue: anObject [ 
	initialValue := anObject
]

{ #category : #running }
LcsPrimitiveSlotDefinitionBuilderTest >> removeArtifactsRelatedToSlot [
	self slotName
		ifNotNil: [ 
			self targetClass removeDomainSlotNamed: self slotName.
			self targetClass assertDomainSlotRemoved: self slotName ]
]

{ #category : #tests }
LcsPrimitiveSlotDefinitionBuilderTest >> slotBuilderClass [
	^ slotBuilderClass
]

{ #category : #tests }
LcsPrimitiveSlotDefinitionBuilderTest >> slotBuilderClass: aBuilderClass [ 
	slotBuilderClass := aBuilderClass
]

{ #category : #tests }
LcsPrimitiveSlotDefinitionBuilderTest >> slotGetterName [
	^self slotName asSymbol
]

{ #category : #accessing }
LcsPrimitiveSlotDefinitionBuilderTest >> slotName [
	^ slotName
]

{ #category : #accessing }
LcsPrimitiveSlotDefinitionBuilderTest >> slotName: anObject [
	slotName := anObject
]

{ #category : #tests }
LcsPrimitiveSlotDefinitionBuilderTest >> slotSetterName [
	^ (self slotName , ':') asSymbol
]

{ #category : #tests }
LcsPrimitiveSlotDefinitionBuilderTest >> targetClass [
	^ targetClass
]

{ #category : #tests }
LcsPrimitiveSlotDefinitionBuilderTest >> targetClass: aClass [
	targetClass := aClass 
]

{ #category : #running }
LcsPrimitiveSlotDefinitionBuilderTest >> tearDown [
	self removeArtifactsRelatedToSlot.
	super tearDown
]
