Class {
	#name : 'LcsSystemSupportModule',
	#superclass : 'LcsModule',
	#instVars : [
		'justifications'
	],
	#category : 'Lcs-SystemSupport-Core',
	#package : 'Lcs-SystemSupport',
	#tag : 'Core'
}

{ #category : 'slot definitions' }
LcsSystemSupportModule class >> configurationSlotDefinition [
	<accessorSlotDefinition>
	^ self configurationSlotDefinitionOn: self moduleConfigurationClass
]

{ #category : 'configuration' }
LcsSystemSupportModule class >> defaultModuleName [
	^ 'SystemSupport'
]

{ #category : 'slot definitions' }
LcsSystemSupportModule class >> justificationsSlotDefinition [
	<accessorSlotDefinition>
	^ LcsValueObjectsGlobalCollectionSlot new
		addSlotType: LcsJustifications;
		addCollectionMemberType: LcsJustification;
		slotName: 'justifications';
		loaderClass: LcsJustificationsLoader;
		yourself
]

{ #category : 'generated method' }
LcsSystemSupportModule class >> moduleConfigurationClass [
	^ LcsSystemSupportModuleConfiguration
]

{ #category : 'configuration' }
LcsSystemSupportModule class >> owningModules [
	<owningModule: 'LcsDemoSystem' priority: 2>
	<owningModule: 'LcsWarRabbitLibrary' priority: 2>
	<owningModule: 'LxxPrototypeSystem' priority: 2>
	<owningModule: 'LcsSailingClubSystem' priority: 2>
	<owningModule: 'LcsBasicSystem' priority: 2>
]

{ #category : 'accessing' }
LcsSystemSupportModule >> justifications [
	^ self slotVarNamed: 'justifications'
]

{ #category : 'as yet unclassified' }
LcsSystemSupportModule >> justifications: anObject [
	self slotVarNamed: 'justifications' put: anObject
]
