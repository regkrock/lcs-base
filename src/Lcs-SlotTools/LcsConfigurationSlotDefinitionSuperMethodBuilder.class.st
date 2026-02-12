Class {
	#name : 'LcsConfigurationSlotDefinitionSuperMethodBuilder',
	#superclass : 'LcsMethodBuilder',
	#instVars : [
		'owningModuleClass',
		'moduleName'
	],
	#category : 'Lcs-SlotTools-Core',
	#package : 'Lcs-SlotTools',
	#tag : 'Core'
}

{ #category : 'initialize' }
LcsConfigurationSlotDefinitionSuperMethodBuilder >> initialize [
	super initialize.
	self categoryName: #'slot definitions';
	beClassMethod
]

{ #category : 'command' }
LcsConfigurationSlotDefinitionSuperMethodBuilder >> methodSource [
	^ self selector , '
	<accessorSlotDefinition>
	^ self configurationSlotDefinitionOn: self moduleConfigurationClass'
]
