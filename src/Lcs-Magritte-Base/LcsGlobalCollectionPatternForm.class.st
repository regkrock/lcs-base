Class {
	#name : 'LcsGlobalCollectionPatternForm',
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
LcsGlobalCollectionPatternForm class >> builderClass [
	^ LcsDomainClassAndGlobalCollectionClassBuilderJob
]

{ #category : 'magritte' }
LcsGlobalCollectionPatternForm >> buildUnknownClassDescription [
	<magritteDescription>
	^ MABooleanDescription new
		label: 'Build Unknown Class';
		priority: 15;
		accessor: (MAChainAccessor accessors: #(slotModelBuilder buildUnknownClass));
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize
				"+ (BrGlamorousWithExplicitContextMenuAptitude
						itemsWithAnchorActions: [ self contextMenuItemsForSuperclass ])" ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		addCondition: [ :aValue | aValue asString trim size >= 3 ] labelled: 'Enter a unique class prefix name of at least two characters in length';
		addCondition: [ :aValue | aValue asString trim asSymbol allSatisfy: [ :each | each isCharacter ] ] labelled: 'Slot Names can contain only alphas';
		beRequired
]

{ #category : 'initialize' }
LcsGlobalCollectionPatternForm >> initializeOn: aTarget [
	super initializeOn: aTarget.
	self slotModelBuilder collectionSlotInstallationTargetClass: self targetClass.

]

{ #category : 'accessing' }
LcsGlobalCollectionPatternForm >> targetClassNameChangedTo: aString [
	super targetClassNameChangedTo: aString.
	self slotModelBuilder collectionSlotInstallationTargetClass: ([ aString asClass ] on: NotFound do: [ :s | s return: nil ])
]
