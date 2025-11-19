Class {
	#name : 'LcsValueCollectionPatternForm',
	#superclass : 'LcsMultislotPatternForm',
	#instVars : [
		'packageAndTagName',
		'onElementCreated',
		'slotClassName'
	],
	#category : 'Lcs-Magritte-Base-Forms - Models',
	#package : 'Lcs-Magritte-Base',
	#tag : 'Forms - Models'
}

{ #category : 'configuration' }
LcsValueCollectionPatternForm class >> builderClass [
	^ LcsStandardValueObjectClassesBuilderJob
]

{ #category : 'magritte' }
LcsValueCollectionPatternForm >> buildUnknownClassDescription [
	"<magritteDescription>"
	^ MABooleanDescription new
		label: 'Build Unknown Class';
		priority: 3;
		accessor: (MAChainAccessor accessors: #(slotModelBuilder buildUnknownClass));
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		beRequired
]

{ #category : 'initialize' }
LcsValueCollectionPatternForm >> initializeOn: aTarget [
	super initializeOn: aTarget.
	self slotModelBuilder collectionSlotInstallationTargetClass: self targetClass.

]
