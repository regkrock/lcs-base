Class {
	#name : 'LcsDomainClassAndLocalCollectionClassBuilderJobExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SlotToolsTests-Examples',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Examples'
}

{ #category : 'private' }
LcsDomainClassAndLocalCollectionClassBuilderJobExamples >> invoiceAndInvoicesBuilderJob [
	^ LcsDomainClassAndGlobalCollectionClassBuilderJobExamples new invoiceAndInvoicesBuilderJob
]

{ #category : 'examples' }
LcsDomainClassAndLocalCollectionClassBuilderJobExamples >> invoiceItemAndLocalInvoiceItemsCreationJob [
	<gtExample>
	| builderJob |
	builderJob :=  self newBuilderJob
					classPrefix: 'Lxx';
					createForRootName: 'InvoiceItem';
					installNewClassesInPackageNamed: 'Lcs-Temp';
					"installCollectionSlotInClass: #LxxInvoice asClass;"
					installCollectionSlotInClassName: #LxxInvoice;
					yourself.
	"self error: 'Add tests here to sort out the problem when the class does not yet exist.'."
	builderJob buildJobSteps.
	^ builderJob
]

{ #category : 'examples' }
LcsDomainClassAndLocalCollectionClassBuilderJobExamples >> invoiceItemAndLocalInvoiceItemsCreationJobInstallationAndRemoval [
	<gtExample>
	| builderJob invoiceBuilderJob|
	invoiceBuilderJob := self invoiceAndInvoicesBuilderJob.
	builderJob :=  self invoiceItemAndLocalInvoiceItemsCreationJob.
	[ invoiceBuilderJob execute.
	  invoiceBuilderJob verifyCodeInstallation.
	  builderJob execute.
	  builderJob verifyCodeInstallation.
	  self verifyInstallationOf: builderJob ]
		ensure: [
			builderJob uninstall.
			builderJob verifyUninstall.
			invoiceBuilderJob uninstall.
			invoiceBuilderJob verifyUninstall ].
	^ builderJob

]

{ #category : 'examples' }
LcsDomainClassAndLocalCollectionClassBuilderJobExamples >> invoiceItemAndLocalInvoiceItemsCreationJobWithoutInoiceItemsSlotInInvoice [
	<gtExample>
	| builderJob |
	builderJob :=  self invoiceItemAndLocalInvoiceItemsCreationJob.
	builderJob jobSteps removeLast.
	^ builderJob
]

{ #category : 'examples' }
LcsDomainClassAndLocalCollectionClassBuilderJobExamples >> newBuilderJob [
	<gtExample>
	| builderJob |
	builderJob := LcsDomainClassAndLocalCollectionClassBuilderJob new.
	^ builderJob
]

{ #category : 'validation' }
LcsDomainClassAndLocalCollectionClassBuilderJobExamples >> verifyInstallationOf: builderJob [ 
	| newInvoice newInvoiceItem |
	
	"This code creates ok but there is problems when the changes 
	 are uninstalled. The instances need to be removed first."
	
	"newInvoice := #LxxInvoice asClass new.
	self assert: newInvoice invoiceItems collectionSize = 0.
	self assert: (newInvoice invoiceItems isKindOf: #LxxInvoiceItems asClass).
	"self currentSystem applyChanges."
	newInvoiceItem := newInvoice invoiceItems add: #LxxInvoiceItem asClass new.
	self assert: newInvoiceItem parent == newInvoice invoiceItems.
	"self currentSystem applyChanges."
	self assert: (newInvoice invoiceItems includes: newInvoiceItem)"
]
