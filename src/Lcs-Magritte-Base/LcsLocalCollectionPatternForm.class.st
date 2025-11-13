Class {
	#name : #LcsLocalCollectionPatternForm,
	#superclass : #LcsMultislotPatternForm,
	#instVars : [
		'packageAndTagName',
		'onElementCreated',
		'slotClassName'
	],
	#category : #'Lcs-Magritte-Base-Forms - Models'
}

{ #category : #configuration }
LcsLocalCollectionPatternForm class >> builderClass [
	^ LcsDomainClassAndLocalCollectionClassBuilderJob
]

{ #category : #magritte }
LcsLocalCollectionPatternForm >> domainSuperclassDescription [
	<magritteDescription>
	| magritteDescription |
	magritteDescription := MAStringDescription new
		label: 'Domain Superclass';
		priority: 15;
		accessor: (MAChainAccessor accessors: #(slotModelBuilder newDomainClassSuperclass));
		readOnly: (self mode = #edit);
		default: '';
		blocShortcuts: [ 
			{BlShortcutWithAction new
				name: 'Browse class';
				description: 'Browses the class indicated by the editor';
				combination: BlKeyCombination primaryB;
				action: [ :anEvent | anEvent target phlow spawnTool: (GtClassCoderTool forClass: anEvent target text asString asClass) ].
			BlShortcutWithAction new
				name: 'Inspect class';
				description: 'Inspects the class indicated by the editor';
				combination: BlKeyCombination primaryG;
				action: [ :anEvent | anEvent target phlow spawnObject: anEvent target text asString asClass ].
			BlShortcutWithAction new
				name: 'Browse class references';
				description: 'Browses references to the class indicated by the editor';
				combination: BlKeyCombination primaryN;
				action: [ :anEvent | anEvent target phlow spawnObject: anEvent target text asString asClass gtReferences ]} ];
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		beRequired.
	self decorateTargetClassDescription: magritteDescription.
	^magritteDescription
]

{ #category : #initialize }
LcsLocalCollectionPatternForm >> initializeOn: aTarget [
	super initializeOn: aTarget.
	self slotModelBuilder collectionSlotInstallationTargetClass: self targetClass.

]

{ #category : #accessing }
LcsLocalCollectionPatternForm >> targetClassNameChangedTo: aString [
	super targetClassNameChangedTo: aString.
	self slotModelBuilder collectionSlotInstallationTargetClass: ([ aString asClass ] on: NotFound do: [ :s | s return: nil ])
]

{ #category : #magritte }
LcsLocalCollectionPatternForm >> targetDomainClassesDescription [
	^ nil
]
