Configuration Sample_ChangeDescriptionAndPermissions
{
    Import-DscResource -Module xSmbShare
   # A Configuration block can have zero or more Node blocks
   Node $NodeName
   {
        # Next, specify one or more resource blocks

      xSmbShare MySMBShare
      {
          Ensure      = "Present" 
          Name        = "MyShare"
          Path        = "C:\Demo\Temp"  
          ReadAccess  = "JSnover"
          FullAccess  = "IanLucas"
          Description = "This is an updated description for this share"
      }
   }
} 
